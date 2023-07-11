import type { NextPage, GetServerSideProps } from "next";
import Head from "next/head";
import Image from "next/image";
import styles from "../styles/Home.module.css";

export const getServerSideProps: GetServerSideProps<Props> = async () => {
  const res = await fetch(
    "https://jsonplaceholder.typicode.com/posts?_limit=10"
  );
  const posts = await res.json();

  return {
    props: {
      posts,
    },
  };
};

interface Post {
  id: number;
  title: string;
  body: string;
}

type Props = {
  posts: Post[];
};

const Home: NextPage<Props> = ({ posts }) => {
  return (
    <>
      <div className={styles.container}>
        {posts.map((post) => (
          <div key={post.id} className={styles.card}>
            <h3>{post.title}</h3>
            <p>{post.body}</p>
          </div>
        ))}
      </div>
    </>
  );
};

export default Home;
